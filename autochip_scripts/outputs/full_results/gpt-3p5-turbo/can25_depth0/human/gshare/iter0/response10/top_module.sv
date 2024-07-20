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

reg [6:0] global_history;
reg [6:0] index;
reg [1:0] pht[0:127];

always @(posedge clk) begin
    if (areset) begin
        global_history <= 0;
        pht <= 2'b00;
    end else begin
        if (train_valid) begin
            index <= train_pc ^ global_history;
            if (train_mispredicted) begin
                global_history <= train_history;
            end
            pht[index] <= train_taken ? (pht[index] == 2'b11 ? 2'b11 : pht[index] + 2'b01) : (pht[index] == 2'b00 ? 2'b00 : pht[index] - 2'b01);
        end else if (predict_valid) begin
            index <= predict_pc ^ global_history;
            predict_taken <= pht[index][1];
            predict_history <= global_history;
        end
    end
end

endmodule
