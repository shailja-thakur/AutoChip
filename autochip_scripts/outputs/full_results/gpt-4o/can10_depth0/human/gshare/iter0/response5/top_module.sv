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
    reg [1:0] PHT[0:127];
    reg [6:0] global_history;

    // Initialize the PHT and branch history register on reset
    integer i;
    always @(posedge areset or posedge clk) begin
        if (areset) begin
            for (i = 0; i < 128; i = i + 1) begin
                PHT[i] <= 2'b01; // Weakly not taken
            end
            global_history <= 7'd0;
        end else begin
            if (train_valid) begin
                // Update the PHT based on the train outcome
                case (PHT[train_pc ^ train_history])
                    2'b00: PHT[train_pc ^ train_history] <= train_taken ? 2'b01 : 2'b00; // Strongly not taken to weakly not taken or remains strongly not taken
                    2'b01: PHT[train_pc ^ train_history] <= train_taken ? 2'b10 : 2'b00; // Weakly not taken to weakly taken or strongly not taken
                    2'b10: PHT[train_pc ^ train_history] <= train_taken ? 2'b11 : 2'b01; // Weakly taken to strongly taken or weakly not taken
                    2'b11: PHT[train_pc ^ train_history] <= train_taken ? 2'b11 : 2'b10; // Strongly taken remains or weakly taken
                endcase

                // Update global branch history register
                if (train_mispredicted)
                    global_history <= {global_history[5:0], train_taken};
                else
                    global_history <= {train_history[5:0], train_taken};
            end else if (predict_valid) begin
                // Update the global history for the predicted branch
                global_history <= {global_history[5:0], predict_taken};
            end
        end
    end

    always @(*) begin
        predict_history = global_history;
        if (predict_valid) begin
            // Make a prediction based on the current state of the PHT
            case (PHT[predict_pc ^ global_history])
                2'b00, 2'b01: predict_taken = 1'b0; // Strongly or weakly not taken
                2'b10, 2'b11: predict_taken = 1'b1; // Weakly or strongly taken
            endcase
        end else begin
            predict_taken = 1'b0;
        end
    end
endmodule
