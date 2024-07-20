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

reg [6:0] pht_index; // index into the pattern history table
reg [1:0] pht_state; // state in the pattern history table

reg [6:0] bhr; // branch history register

reg predict_taken_reg;
reg [6:0] predict_history_reg;

reg update_pht;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        pht_index <= 0;
        pht_state <= 0;
        bhr <= 0;
        predict_taken_reg <= 0;
        predict_history_reg <= 0;
    end else begin
        // predict branch direction
        if (predict_valid) begin
            predict_history_reg <= bhr;
            if (pht_state[1] == 2'b00 || pht_state[1] == 2'b01) begin
                predict_taken_reg <= 0;
            end else begin
                predict_taken_reg <= 1;
            end
        end
    
        // update pht and bhr
        if (update_pht) begin
            if (train_mispredicted) begin
                pht_state[pht_index] <= pht_state[pht_index] - 1;
                bhr <= train_history;
            end else if (train_taken) begin
                pht_state[pht_index] <= pht_state[pht_index] + 1;
            end
        end
    end
end

always @(posedge clk) begin
    if (areset) begin
        update_pht <= 0;
    end else begin
        if (predict_valid) begin
            pht_index <= predict_pc ^ bhr;
        end else if (train_valid) begin
            update_pht <= 1;
            pht_index <= train_pc ^ train_history;
        end else begin
            update_pht <= 0;
        end
    end
end

assign predict_taken = predict_taken_reg;
assign predict_history = predict_history_reg;

endmodule
