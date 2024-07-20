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
reg [6:0] history;

// PHT access
wire [6:0] p_index;
assign p_index = predict_pc ^ history;
wire [1:0] p_counter;
assign p_counter = pht[p_index];

// Prediction
reg [6:0] p_pc;
reg p_valid;
wire p_taken;
wire [6:0] p_history;
assign predict_taken = p_taken;
assign predict_history = p_history;

// Training
reg [6:0] t_pc;
reg t_valid;
reg t_taken;
reg t_mispredicted;
reg [6:0] t_history;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        history <= 7'b0;
    end else begin
        if (predict_valid) begin
            p_pc <= predict_pc;
            p_valid <= 1'b1;
            p_taken <= p_counter[1];
            p_history <= history;
        end else begin
            p_pc <= 7'b0;
            p_valid <= 1'b0;
            p_taken <= 1'b0;
            p_history <= 7'b0;
        end

        if (train_valid) begin
            t_pc <= train_pc;
            t_valid <= 1'b1;
            t_taken <= train_taken;
            t_mispredicted <= train_mispredicted;
            t_history <= train_history;
        end else begin
            t_pc <= 7'b0;
            t_valid <= 1'b0;
            t_taken <= 1'b0;
            t_mispredicted <= 1'b0;
            t_history <= 7'b0;
        end

        if (p_valid && !t_valid) begin
            history <= {history[5:0], p_taken};
        end else if (!p_valid && t_valid) begin
            history <= t_history;
        end else if (p_valid && t_valid) begin
            history <= t_history;
        end else begin
            history <= history;
        end
    end
end

always @(*) begin
    if (p_valid) begin
        predict_taken = p_taken;
        predict_history = p_history;
    end else begin
        predict_taken = 1'b0;
        predict_history = 7'b0;
    end
end

// Training logic
always @(posedge clk) begin
    if (t_valid && t_mispredicted) begin
        pht[p_index] <= p_counter - 1;
    end else if (t_valid) begin
        pht[p_index] <= p_counter + 1;
    end
end

// Initializations
initial begin
    foreach (pht[i]) begin
        pht[i] = 2'b0;
    end
end

endmodule
