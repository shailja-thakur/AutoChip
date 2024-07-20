module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);
    // State encoding
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;

    state_t current_state, next_state;

    // State table: Combinational logic to determine next state
    always @(*) begin
        case (current_state)
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
            B: begin
                if (r[1])
                    next_state = B;
                else
                    next_state = A;
            end
            C: begin
                if (r[2])
                    next_state = C;
                else
                    next_state = A;
            end
            D: begin
                next_state = A;
            end
            default: next_state = A;
        endcase
    end

    // State flip-flops: Sequential logic to update current state
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            current_state <= A;
        else
            current_state <= next_state;
    end

    // Output logic: Logic to determine the value of g
    always @(*) begin
        g = 3'b000;
        case (current_state)
            B: g[1] = 1;
            C: g[2] = 1;
            D: g[3] = 1;
            default: g = 3'b000;
        endcase
    end

endmodule
