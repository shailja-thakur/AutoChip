module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

     // Define states
    parameter B = 2'b00;
    parameter A = 2'b01;

    reg [1:0] state_q, state_d; 

    always @(posedge clk or posedge areset)
    begin
        if (areset)
            state_q <= B;
        else
            state_q <= state_d;
    end
   
    always @(state_q or in)
    begin
        case(state_q)
            B: begin
                if (in)
                    state_d <= A;
                else
                    state_d <= B;
            end
            A: begin
                if (in)
                    state_d <= A;
                else
                    state_d <= B;
            end
        endcase
    end

    always @(state_q)
    begin
        case (state_q)
            B: out = 1'b0;
            A: out = 1'b1;
        endcase
    end

endmodule
