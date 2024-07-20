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

    reg [6:0] branch_history_register;
    reg [6:0] index;
    wire [1:0] prediction;
    reg [1:0] table [0:127];

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            branch_history_register <= 7'b0;
        end else if (predict_valid) begin
            index <= predict_pc ^ branch_history_register;
            predict_taken <= table[index] >= 2'b10;
            predict_history <= branch_history_register;
        end else if (train_valid) begin
            branch_history_register <= train_history;
            index <= train_pc ^ branch_history_register;
            if (train_mispredicted) begin
                if (table[index] == 2'b11) begin
                    table[index] <= 2'b10;
                end else if (table[index] == 2'b10) begin
                    table[index] <= 2'b00;
                end else if (table[index] == 2'b01) begin
                    table[index] <= 2'b00;
                end else if (table[index] == 2'b00) begin
                    table[index] <= 2'b00;
                end
            end else begin
                if (train_taken) begin
                    if (table[index] == 2'b11) begin
                        table[index] <= 2'b11;
                    end else if (table[index] == 2'b10) begin
                        table[index] <= 2'b11;
                    end else if (table[index] == 2'b01) begin
                        table[index] <= 2'b11;
                    end else if (table[index] == 2'b00) begin
                        table[index] <= 2'b01;
                    end
                end else begin
                    if (table[index] == 2'b11) begin
                        table[index] <= 2'b10;
                    end else if (table[index] == 2'b10) begin
                        table[index] <= 2'b10;
                    end else if (table[index] == 2'b01) begin
                        table[index] <= 2'b00;
                    end else if (table[index] == 2'b00) begin
                        table[index] <= 2'b00;
                    end
                end
            end
        end
    end
endmodule
