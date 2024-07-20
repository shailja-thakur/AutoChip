module top_module(
    input clk,
    input areset,

    input predict_valid,
    input [6:0] predict_pc,
    output predict_taken,
    output [6:0] predict_history,

    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history,
    input [6:0] train_pc
);

reg [6:0] global_history_register;
reg [6:0] pattern_history_table [0:127];
reg predict_taken;
wire [6:0] index;
wire [1:0] counter_output;
wire [6:0] history;

// initial values
initial begin
    global_history_register = 7'b0000000;
    for (int i = 0; i < 128; i = i + 1) begin
        pattern_history_table[i] = 2'b00;
    end
end

// prediction process
always @(posedge clk or posedge areset) begin
    if (areset) begin
        global_history_register <= 7'b0000000;
    end else begin
        // get history bits
        history <= global_history_register ^ predict_pc;
        index <= history[6:0];

        // predict taken or not taken based on counter output
        if (pattern_history_table[index] < 2'b10) begin
            predict_taken <= 1'b0;
        end else begin
            predict_taken <= 1'b1;
        end

        // update predict history
        predict_history <= global_history_register;
    end
end

// training process
always @(posedge clk or posedge areset) begin
    if (areset) begin
        global_history_register <= 7'b0000000;
    end else begin
        if (train_valid) begin
            // get history bits
            history <= global_history_register ^ train_pc;
            index <= history[6:0];

            // train pattern history table
            if (train_mispredicted) begin
                pattern_history_table[index] <= pattern_history_table[index] - 2'b10;
            end else begin
                pattern_history_table[index] <= pattern_history_table[index] + 2'b01;
            end
        end
    end
end

endmodule
