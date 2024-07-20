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

reg [6:0] ghr;
reg [6:0] index;
reg [1:0] counter [0:127];

assign predict_taken = counter[index] > 1 ? 1 : 0;
assign predict_history = ghr;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        ghr <= 7'b0;
    end else if (train_valid) begin
        ghr <= {ghr[5:0], train_taken};
    end else if (predict_valid) begin
        ghr <= {ghr[5:0], predict_taken};
    end
end

always @(posedge clk or posedge areset) begin
    if (areset) begin
        for (integer i = 0; i < 128; i = i + 1) begin
            counter[i] <= 2'b0;
        end
    end else if (train_valid) begin
        index <= {train_history ^ train_pc[6:0]};
        if (train_mispredicted) begin
            counter[index] <= counter[index] <= 2'd1 ? 2'd0 : counter[index] - 2'd1;
        end else begin
            counter[index] <= counter[index] >= 2'd2 ? 2'd3 : counter[index] + 2'd1;
        end
    end else if (predict_valid) begin
        index <= {predict_pc ^ ghr[6:0]};
    end
end

endmodule
