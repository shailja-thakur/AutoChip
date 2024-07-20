module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    reg [1:0] state;
    reg [1:0] next_state;

    parameter OFF = 2'b00;
    parameter ON = 2'b01;

    always @(posedge clk, posedge reset) begin
        if (reset) begin
            state <= OFF;
            out <= 0;
        end else begin
            state <= next_state;
            case (state)
                OFF: begin
                    if (j) begin
                        next_state <= ON;
                    end else begin
                        next_state <= OFF;
                    end
                    out <= 0;
                end

                ON: begin
                    if (k) begin
                        next_state <= OFF;
                    end else begin
                        next_state <= ON;
                    end
                    out <= 1;
                end
            endcase
        end
    end

endmodule
