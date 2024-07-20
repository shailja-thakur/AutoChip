module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);

    // State encoding
    typedef enum reg [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;
    
    state_t current_state, next_state;

    // State table (Next state logic)
    always @(*) begin
        case (current_state)
            A: begin
                if (r[1]) begin
                    next_state = B;
                end else if (r[2]) begin
                    next_state = C;
                end else if (r[3]) begin
                    next_state = D;
                end else begin
                    next_state = A;
                end
            end
            B: begin
                if (r[1]) begin
                    next_state = B;
                end else begin
                    next_state = A;
                end
            end
            C: begin
                if (r[2]) begin
                    next_state = C;
                end else begin
                    next_state = A;
                end
            end
            D: begin
                next_state = A; // Device 3 has the lowest priority and transitions back to A
            end
            default: next_state = A;
        endcase
    end

    // State flip-flops (State register)
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            current_state <= A;
        else
            current_state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (current_state)
            A: g = 3'b000;
            B: g = 3'b001; // g1
            C: g = 3'b010; // g2
            D: g = 3'b100; // g3
            default: g = 3'b000;
        endcase
    end
endmodule
