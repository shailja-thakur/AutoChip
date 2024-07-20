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
    
    reg predict_taken;
    reg [6:0] predict_history;
    wire [6:0] index;
    wire [1:0] predict_state;
    wire predict;
    
    reg [6:0] train_history_reg;
    wire [6:0] index_train;
    reg [1:0] train_state;
    
    reg [6:0] pht [0:127];
    
    assign index = predict_pc ^ predict_history;
    assign predict = pht[index] >= 2'b10 ? 1'b1 : 1'b0;
    assign predict_taken = predict;
    assign predict_history = predict_valid ? predict_state : predict_history;
    
    assign index_train = train_pc ^ train_history_reg;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            pht <= 128'h00000000000000000000000000000000;
            train_history_reg <= 7'b0000000;
        end else begin
            if (predict_valid) begin
                predict_taken <= predict;
                predict_history <= predict_state;
            end else if (train_valid) begin
                if (train_mispredicted) begin
                    pht[index_train] <= predict_state <= 2'b00;
                    train_history_reg <= train_history;
                end else begin
                    pht[index_train] <= predict_state;
                end
            end
        end
    end
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            train_state <= 2'b00;
        end else begin
            if (train_valid) begin
                if (train_state == 2'b00) begin
                    train_state <= 2'b01;
                end else if (train_state == 2'b01) begin
                    train_state <= 2'b10;
                end
            end else if (predict_valid) begin
                train_state <= 2'b00;
            end
        end
    end
    
    assign predict_state = train_state[1:0];
    
endmodule
