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
    reg [6:0] pht_index;
    reg [1:0] pht_value;
    reg [6:0] predicted_pc;
    reg predict_taken;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            ghr <= 7'b0;
            pht_index <= 7'b0;
            pht_value <= 2'b0;
            predicted_pc <= 7'b0;
        end else begin
            if (train_valid) begin
                ghr <= train_history;
                pht_index <= train_pc ^ ghr;
                if (predict_valid && (predict_pc == train_pc)) begin
                    pht_index <= predict_pc ^ ghr;
                end
                pht_value <= pht_value + 2'b01;
                if (train_mispredicted) begin
                    pht_value <= pht_value - 2'b01;
                end
            end else if (predict_valid) begin
                ghr <= ghr << 1;
                ghr[0] <= predict_taken;
                pht_index <= predict_pc ^ ghr;
                predicted_pc <= predict_pc;
            end
        end
    end

    assign predict_history = ghr;
    assign predict_taken = (pht_value[1] != 0);

endmodule
