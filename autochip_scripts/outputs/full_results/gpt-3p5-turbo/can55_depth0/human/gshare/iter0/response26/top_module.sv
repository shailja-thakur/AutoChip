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
    reg [6:0] pht_index;
    reg [1:0] pht_state;
    reg prediction_taken;

    always @(posedge clk or posedge areset) begin
        if (areset)
            global_history <= 0;
        else if (train_valid) begin
            pht_index <= train_pc ^ train_history;
            
            if (train_mispredicted == 1)
                pht_state <= 0;
            else if (train_taken == 1) begin
                if (pht_state < 3)
                    pht_state <= pht_state + 1;
            end else begin
                if (pht_state > 0)
                    pht_state <= pht_state - 1;
            end
        end else begin
            if (predict_valid) begin
                pht_index <= predict_pc ^ global_history;
                predict_taken <= (pht_state >= 2) ? 1'b1 : 1'b0;
                predict_history <= global_history;
            end
        end

        if (train_valid)
            global_history <= {global_history[5:0], train_taken};
    end

endmodule
