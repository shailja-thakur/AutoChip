module top_module(
	input clk,
	input areset,
	input predict_valid,
	input [6:0] predict_pc,
	output predict_taken,
	output reg [6:0] predict_history,
	input train_valid,
	input train_taken,
	input train_mispredicted,
	input [6:0] train_history,
	input [6:0] train_pc
);

reg [6:0] predict_index;
reg [1:0] predict_counter;
wire [1:0] predict_state;
wire [6:0] predict_index_shift;
reg [6:0] train_index;
wire [1:0] train_state;
reg [6:0] train_index_shift;
reg [1:0] train_counter;
reg [6:0] pht [0:127];
wire [1:0] train_new_state;

// Prediction interface
assign predict_taken = (predict_state == 2'b11);
assign predict_history = predict_index;
always @(posedge clk) begin
    if (areset) begin
        predict_history <= 7'b0;
    end else if (predict_valid) begin
        predict_index <= predict_pc ^ predict_history;
        predict_index_shift <= {predict_index[5:0], 1'b0};
    end else begin
        predict_index_shift <= {predict_index_shift[5:0], 1'b0};
    end
end

// Training interface
always @(posedge clk) begin
    if (areset) begin
        train_index <= 7'b0;
        train_counter <= 2'b0;
    end else if (train_valid) begin
        train_index <= train_pc ^ train_history;
        train_index_shift <= {train_index[5:0], 1'b0};
        train_counter <= pht[train_index];
    end else if (predict_valid && predict_index_shift == train_index_shift) begin
        train_counter <= pht[train_index];
    end else begin
        train_index_shift <= {train_index_shift[5:0], 1'b0};
    end
end

always @(posedge clk) begin
    if (areset) begin
        pht <= 128'b0;
    end else if (train_valid) begin
        pht[train_index] <= train_new_state;
    end else if (predict_valid) begin
        predict_counter <= pht[predict_index_shift];
        predict_state <= predict_counter;
    end
end

always @(posedge clk) begin
    if (areset) begin
        pht <= 128'b0;
    end else if (train_valid) begin
        pht[train_index] <= train_new_state;
    end
end

always @(posedge clk) begin
    if (areset) begin
        pht <= 128'b0;
    end else if (predict_valid) begin
        predict_counter <= pht[predict_index_shift];
        predict_state <= predict_counter;
    end
end

endmodule
