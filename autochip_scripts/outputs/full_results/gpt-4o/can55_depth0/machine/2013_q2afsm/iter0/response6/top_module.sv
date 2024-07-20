module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);

    // Define states as local parameters for better readability
    localparam A = 2'b00,
               B = 2'b01,
               C = 2'b10,
               D = 2'b11;

    reg [1:0] state, next_state;

    // State register update
    always @(posedge clk or negedge resetn) begin
        if (!resetn) 
            state <= A;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            A: begin
                if (r[1])
                    next_state = B;
                else if (r[2])
                    next_state = C;
                else if (r[3])
                    next_state = D;
                else
                    next_state = A;
            end
            B: next_state = (r[1]) ? B : A;
            C: next_state = (r[2]) ? C : A;
            D: next_state = (r[3]) ? D : A;
            default: next_state = A;
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            B: g = 3'b010;
            C: g = 3'b100;
            D: g = 3'b001;
            default: g = 3'b000;
        endcase
    end

endmodule
