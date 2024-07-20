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

reg [1:0] pht [0:127];
reg [6:0] bhr;

wire [6:0] index = predict_pc ^ bhr;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        bhr <= 0;
        for (integer i = 0; i < 128; i=i+1) begin
            pht[i] <= 0;
        end
    end else begin
        if (train_valid) begin
            pht[index] <= (train_taken ? (pht[index] < 3 ? pht[index] + 1 : 3) : (pht[index] > 0 ? pht[index] - 1 : 0));
            bhr <= {bhr[5:0], train_taken};
        end else if (predict_valid) begin
            predict_taken <= (pht[index] > 1 ? 1 : 0);
            predict_history <= bhr;
        end
    end
end

endmodule
