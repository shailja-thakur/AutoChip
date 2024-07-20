module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    reg [1:0] state;
    reg [2:0] delay;

    parameter S0 = 2'b00;
    parameter S1 = 2'b01;
    parameter S2 = 2'b11;

    always @(posedge clk or negedge aresetn) begin
        if (~aresetn) begin
            state <= S0;
            delay <= 0;
            z <= 0;
        end else begin
            case (state)
                S0: begin
                    if (x == 1'b1) begin
                        state <= S1;
                        delay <= 1;
                    end else begin
                        state <= S0;
                        delay <= 0;
                    end
                end

                S1: begin
                    if (x == 1'b0) begin
                        state <= S2;
                        delay <= 2;
                    end else begin
                        state <= S0;
                        delay <= 0;
                    end
                end

                S2: begin
                    if (x == 1'b1) begin
                        state <= S1;
                        delay <= 1;
                        z <= 1;
                    end else begin
                        state <= S0;
                        delay <= 0;
                    end
                end
            endcase
        end
    end

endmodule
