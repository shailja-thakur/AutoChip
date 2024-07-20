module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    reg [3:0] state;
    reg prev_in;

    parameter S0 = 4'b0000;
    parameter S1 = 4'b0001;
    parameter S2 = 4'b0010;
    parameter S3 = 4'b0011;
    parameter S4 = 4'b0100;

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= S0;
        else begin
            case (state)
                S0: begin
                    if (in)
                        state <= S1;
                    else
                        state <= S0;
                end
                S1: begin
                    if (in)
                        state <= S2;
                    else
                        state <= S0;
                end
                S2: begin
                    if (in)
                        state <= S3;
                    else
                        state <= S0;
                end
                S3: begin
                    if (in)
                        state <= S4;
                    else
                        state <= S0;
                end
                S4: begin
                    if (in)
                        state <= S4;
                    else
                        state <= S0;
                end
            endcase
        end
    end

    always @(posedge clk) begin
        if (state == S2)
            disc <= 1;
        else
            disc <= 0;

        if (state == S4)
            flag <= 1;
        else
            flag <= 0;

        if (state == S3)
            err <= 1;
        else
            err <= 0;
    end
    
    assign prev_in = in;

endmodule
