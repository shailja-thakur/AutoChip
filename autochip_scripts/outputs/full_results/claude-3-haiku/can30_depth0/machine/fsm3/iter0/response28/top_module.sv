module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // Define the states
    localparam STATE_A = 2'b00;
    localparam STATE_B = 2'b01;
    localparam STATE_C = 2'b10;
    localparam STATE_D = 2'b11;

    // State register
    reg [1:0] state;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_A;
            out <= 1'b0;
        end
        else begin
            case (state)
                STATE_A: begin
                    if (in) begin
                        state <= STATE_B;
                    end
                    else begin
                        state <= STATE_A;
                    end
                    out <= 1'b0;
                end
                STATE_B: begin
                    if (in) begin
                        state <= STATE_B;
                    end
                    else begin
                        state <= STATE_C;
                    end
                    out <= 1'b0;
                end
                STATE_C: begin
                    if (in) begin
                        state <= STATE_D;
                    end
                    else begin
                        state <= STATE_A;
                    end
                    out <= 1'b0;
                end
                STATE_D: begin
                    if (in) begin
                        state <= STATE_B;
                    end
                    else begin
                        state <= STATE_C;
                    end
                    out <= 1'b1;
                end
            endcase
        end
    end

endmodule
