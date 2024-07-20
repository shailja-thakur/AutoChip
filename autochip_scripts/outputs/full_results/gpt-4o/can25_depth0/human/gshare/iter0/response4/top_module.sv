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

    // 128-entry table of two-bit saturating counters (2-bit for each entry)
    reg [1:0] PHT [0:127];

    // 7-bit global branch history register
    reg [6:0] global_history;

    // Hash function: XOR of PC and global history
    wire [6:0] predict_index, train_index;
    assign predict_index = predict_pc ^ global_history;
    assign train_index = train_pc ^ train_history;

    integer i;
    // Asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
            for (i = 0; i < 128; i = i + 1) begin
                PHT[i] <= 2'b00; // Initialize with strongly not taken
            end
        end else begin
            if (predict_valid) begin
                // Based on the value in PHT, decide whether to predict taken or not
                predict_taken <= PHT[predict_index][1];
                predict_history <= global_history;
                global_history <= {global_history[5:0], predict_taken};
            end
            
            if (train_valid) begin
                // State transitions of the 2-bit saturating counter
                case (PHT[train_index])
                    2'b00: PHT[train_index] <= train_taken ? 2'b01 : 2'b00;
                    2'b01: PHT[train_index] <= train_taken ? 2'b10 : 2'b00;
                    2'b10: PHT[train_index] <= train_taken ? 2'b11 : 2'b01;
                    2'b11: PHT[train_index] <= train_taken ? 2'b11 : 2'b10;
                endcase
                // Update the global history based on misprediction
                if (train_mispredicted) begin
                    global_history <= {train_history[5:0], train_taken};
                end else begin
                    global_history <= {global_history[5:0], train_taken};
                end
            end
        end
    end
endmodule
