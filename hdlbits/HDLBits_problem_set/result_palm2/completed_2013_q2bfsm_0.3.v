module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
); 

    reg [1:0] state;
    reg f;
    reg g;

    always @(posedge clk or negedge resetn) begin
        if (resetn) begin
            state <= 0;
        end else begin
            case (state)
                0: begin
                    if (x) begin
                        state <= 1;
                        f <= 1;
                    end else begin
                        state <= 0;
                    end
                end
                1: begin
                    if (x) begin
                        state <= 2;
                    end else begin
                        state <= 0;
                    end
                end
                2: begin
                    if (y) begin
                        state <= 3;
                        g <= 1;
                    end else begin
                        state <= 0;
                    end
                end
                3: begin
                    g <= 1;
                end
            endcase
        end
    end

endmodule