module top_module (
    input clk,
    input areset,
    input x,
    output z
);
    reg z;
    reg [2:0] state;

    parameter S0 = 3'b000;
    parameter S1 = 3'b001;
    parameter S2 = 3'b010;

    always @(posedge clk or negedge areset) begin
        if (areset == 0) begin
            state <= S0;
            z <= 1'b0;
        end else begin
            case (state)
                S0: begin
                    if (x == 1'b0) begin
                        state <= S1;
                    end else begin
                        state <= S2;
                    end
                    z <= x;
                end

                S1: begin
                    if (x == 1'b0) begin
                        state <= S1;
                    end else begin
                        state <= S2;
                    end
                    z <= ~z;
                end

                S2: begin
                    if (x == 1'b0) begin
                        state <= S1;
                    end else begin
                        state <= S2;
                    end
                    z <= z;
                end
            endcase
        end
    end
endmodule
