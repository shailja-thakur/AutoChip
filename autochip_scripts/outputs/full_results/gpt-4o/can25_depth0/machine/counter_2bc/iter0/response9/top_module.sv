module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);

    // State encoding
    localparam STATE_0 = 2'b00;
    localparam STATE_1 = 2'b01;
    localparam STATE_2 = 2'b10;
    localparam STATE_3 = 2'b11;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_1;
        end
        else if (train_valid) begin
            case (state)
                STATE_0: begin
                    if (train_taken) begin
                        state <= STATE_1;
                    end
                end
                STATE_1: begin
                    if (train_taken) begin
                        state <= STATE_2;
                    end
                    else begin
                        state <= STATE_0;
                    end
                end
                STATE_2: begin
                    if (train_taken) begin
                        state <= STATE_3;
                    end
                    else begin
                        state <= STATE_1;
                    end
                end
                STATE_3: begin
                    if (!train_taken) begin
                        state <= STATE_2;
                    end
                end
            endcase
        end
    end
endmodule
