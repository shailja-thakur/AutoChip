module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

    reg [2:0] y, Y; // y is the present state, Y is the next state

    // State encoding
    parameter S0 = 3'b000;
    parameter S1 = 3'b001;
    parameter S2 = 3'b010;
    parameter S3 = 3'b011;
    parameter S4 = 3'b100;

    // State register
    always @(posedge clk) begin
        if (reset) 
            y <= S0;
        else 
            y <= Y;
    end

    // Next state logic
    always @(y or x) begin
        case (y)
            S0: begin
                if (x) 
                    Y = S1;
                else 
                    Y = S0;
                z = 0;
            end
            S1: begin
                if (x) 
                    Y = S4;
                else 
                    Y = S1;
                z = 0;
            end
            S2: begin
                if (x) 
                    Y = S1;
                else 
                    Y = S2;
                z = 0;
            end
            S3: begin
                if (x) 
                    Y = S2;
                else 
                    Y = S1;
                z = 1;
            end
            S4: begin
                if (x) 
                    Y = S4;
                else 
                    Y = S3;
                z = 1;
            end
            default: begin
                Y = S0;
                z = 0;
            end
        endcase
    end

endmodule
