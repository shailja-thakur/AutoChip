module top_module (
    input clk,
    input areset,
    input x,
    output z
); 

    reg [1:0] state;
    reg [31:0] din;
    reg [31:0] dout;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 0;
        end else begin
            case (state)
                0: begin
                    if (x == 1'b1) begin
                        state <= 1;
                        din <= x;
                    end else begin
                        state <= 0;
                    end
                end
                1: begin
                    dout <= ~din;
                    state <= 2;
                end
                2: begin
                    dout <= din;
                    state <= 0;
                end
            endcase
        end
    end

    assign z = dout;

endmodule