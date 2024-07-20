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

reg [6:0] ghr; // global history register
reg [6:0] pht_index;
reg [1:0] pht_value;

reg [1:0] predict_state;
reg [1:0] train_state;

reg predict_taken;
reg [6:0] predict_history;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        ghr <= 7'h00;
        pht_value <= 2'b00;
        predict_state <= 2'b00;
        train_state <= 2'b00;
        predict_taken <= 1'b0;
        predict_history <= predict_pc;
    end else begin
        // Prediction stage
        if (predict_valid) begin
            pht_index <= predict_pc ^ ghr;
            predict_state <= pht_value;
            predict_taken <= (predict_state == 2'b11 || predict_state == 2'b10);
            predict_history <= predict_pc;
        end

        // Training stage
        if (train_valid) begin
            pht_index <= train_pc ^ train_history;
            train_state <= pht_value;
            if (train_mispredicted) begin
                pht_value <= (train_state == 2'b00) ? 2'b00 : (train_state - 2'b01);
                ghr <= train_history;
            end else begin
                pht_value <= (train_state != 2'b11) ? (train_state + 2'b01) : 2'b11;
            end
        end
    end
end

endmodule
