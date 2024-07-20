module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    reg [1:0] state;
    reg x_prev, x_pprev;

    parameter S0 = 2'b00;
    parameter S1 = 2'b01;
    parameter S2 = 2'b10;

    always @(posedge clk or negedge aresetn) begin
        if (~aresetn)
            state <= S0;
        else begin
            x_pprev <= x_prev;     // Store x_prev value
            x_prev <= x;           // Store current x value

            case (state)
                S0: begin
                    if (x_pprev == 1'b1 && x_prev == 1'b0 && x == 1'b1)
                        state <= S1;
                    else
                        state <= S0;
                end

                S1: begin
                    if (x_pprev == 1'b1 && x_prev == 1'b1 && x == 1'b0)
                        state <= S2;
                    else
                        state <= S0;
                end

                S2: begin
                    if (x_pprev == 1'b1 && x_prev == 1'b0 && x == 1'b1)
                        state <= S1;
                    else
                        state <= S0;
                end

                default: state <= S0;
            endcase
        end
    end

    always @(*) begin
        if (state == S2)
            z = 1'b1;
        else
            z = 1'b0;
    end

endmodule
