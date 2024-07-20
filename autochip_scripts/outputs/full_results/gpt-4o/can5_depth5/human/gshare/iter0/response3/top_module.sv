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

    // 128-entry table of two-bit saturating counters
    reg [1:0] PHT [0:127];

    // 7-bit global branch history register
    reg [6:0] global_history;

    integer i;

    // Asynchronous reset
    always @ (posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
            for (i = 0; i < 128; i = i + 1) begin
                PHT[i] <= 2'b01; // weakly not taken state
            end
        end
    end

    wire [6:0] predict_index = predict_pc ^ global_history;
    wire [6:0] train_index = train_pc ^ train_history;

    // Prediction logic
    always @ (posedge clk) begin
        if (!areset && predict_valid) begin
            predict_history <= global_history;
            case (PHT[predict_index])
                2'b00, 2'b01: predict_taken <= 0;
                2'b10, 2'b11: predict_taken <= 1;
            endcase
            // Update global history with the predicted taken/not taken
            global_history <= {global_history[5:0], predict_taken};
        end
    end

    // Training logic
    always @ (posedge clk) begin
        if (!areset && train_valid) begin
            // Update PHT entry
            if (train_taken) begin
                if (PHT[train_index] != 2'b11) begin
                    PHT[train_index] <= PHT[train_index] + 1;
                end
            end 
            else begin
                if (PHT[train_index] != 2'b00) begin
                    PHT[train_index] <= PHT[train_index] - 1;
                end
            end

            // If mispredicted, recover global history
            if (train_mispredicted) begin
                global_history <= {train_history[5:0], train_taken};
            end 
            else begin
                global_history <= {global_history[5:0], train_taken};
            end
        end
    end

endmodule
