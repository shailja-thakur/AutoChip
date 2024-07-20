module top_module(
    input clk,
    input areset,

    input predict_valid,
    input [6:0] predict_pc,
    output reg predict_taken,
    output reg [6:0] predict_history,

    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history,
    input [6:0] train_pc
);

    reg [1:0] pht[127:0];
    reg [6:0] global_history;

    // Branch prediction
    wire [6:0] index = predict_pc ^ global_history;
    always @(*) begin
        if (predict_valid) begin
            predict_taken = pht[index][1];
            predict_history = global_history;
        end else begin
            predict_taken = 0;
            predict_history = 0;
        end
    end

    // Branch training
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 0;
            for (int i = 0; i < 128; i++) begin
                pht[i] <= 2'b01;
            end
        end else begin
            if (train_valid) begin
                // Update global history
                if (train_mispredicted) begin
                    global_history <= train_history;
                end else begin
                    global_history <= (global_history << 1) | train_taken;
                end

                // Update PHT
                wire [6:0] index = train_pc ^ train_history;
                if (train_taken) begin
                    pht[index] <= (pht[index] == 2'b11) ? 2'b11 : pht[index] + 1;
                end else begin
                    pht[index] <= (pht[index] == 2'b00) ? 2'b00 : pht[index] - 1;
                end
            end
        end
    end

endmodule
