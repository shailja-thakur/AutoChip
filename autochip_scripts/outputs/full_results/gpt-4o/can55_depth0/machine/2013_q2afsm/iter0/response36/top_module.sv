module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);

    // Define the states
    typedef enum reg [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;
    
    // State registers
    reg [1:0] state, next;

    // Update the state on the rising edge of the clock or reset
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= A;
        else
            state <= next;
    end

    // Determine the next state based on the current state and input r
    always @(*) begin
        case (state)
            A: begin
                if (r[1])
                    next = B;
                else if (r[2])
                    next = C;
                else if (r[3])
                    next = D;
                else
                    next = A;
            end
            B: begin
                if (r[1])
                    next = B;
                else
                    next = A;
            end
            C: begin
                if (r[2])
                    next = C;
                else
                    next = A;
            end
            D: begin
                if (r[3])
                    next = D;
                else
                    next = A;
            end
            default: next = A;
        endcase
    end

    // Determine the output based on the current state
    always @(*) begin
        case (state)
            A: g = 3'b000;
            B: g = 3'b001;
            C: g = 3'b010;
            D: g = 3'b100;
            default: g = 3'b000;
        endcase
    end

endmodule
