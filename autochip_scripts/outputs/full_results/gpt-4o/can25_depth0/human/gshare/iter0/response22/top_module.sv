module top_module(
    input clk,
    input areset,

    input predict_valid,
    input [6:0] predict_pc,
    output reg predict_taken,
    output reg [6:0] predict_history,

    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history,
    input [6:0] train_pc
);

    // Two-bit saturating counter values
    localparam STRONGLY_NOT_TAKEN = 2'b00;
    localparam WEAKLY_NOT_TAKEN   = 2'b01;
    localparam WEAKLY_TAKEN       = 2'b10;
    localparam STRONGLY_TAKEN     = 2'b11;

    reg [1:0] PHT [0:127];        // 128-entry Pattern History Table with 2-bit counters
    reg [6:0] global_history;     // Global 7-bit branch history register

    integer i;
    
    // Asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
            for (i = 0; i < 128; i = i + 1) begin
                PHT[i] <= WEAKLY_NOT_TAKEN;
            end
        end else begin
            if (train_valid) begin
                // Hash the PC and train_history to get the table index
                reg [6:0] idx;
                idx = train_pc ^ train_history;

                // Update the PHT entry
                if (train_taken) begin
                    if (PHT[idx] != STRONGLY_TAKEN) begin
                        PHT[idx] <= PHT[idx] + 1;
                    end
                end else begin
                    if (PHT[idx] != STRONGLY_NOT_TAKEN) begin
                        PHT[idx] <= PHT[idx] - 1;
                    end
                end

                // Update the global history register based on the train outcome
                if (train_mispredicted) begin
                    global_history <= {train_history[6:1], train_taken};
                end else begin
                    global_history <= {global_history[5:0], train_taken};
                end
            end else if (predict_valid) begin
                global_history <= {global_history[5:0], predict_taken};
            end
        end
    end

    // Handle predictions
    always @(*) begin
        if (predict_valid) begin
            // Hash the PC and global history to get the table index
            reg [6:0] idx;
            idx = predict_pc ^ global_history;

            // Read the PHT entry and decide on the prediction
            case (PHT[idx])
                STRONGLY_NOT_TAKEN, WEAKLY_NOT_TAKEN: predict_taken = 0;
                WEAKLY_TAKEN, STRONGLY_TAKEN: predict_taken = 1;
                default: predict_taken = 0;
            endcase

            // Provide the current state of the branch history register
            predict_history = global_history;
        end else begin
            predict_taken = 0;
            predict_history = global_history;
        end
    end

endmodule
