module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);
      
    /* State Codes:
        A: 2'b00
        B: 2'b01
        C: 2'b10
        D: 2'b11
    */
      
    reg [1:0] state, next_state;
      
    // State flip-flops
    always @(posedge clk or negedge resetn) begin
        if (~resetn) begin
            state <= 2'b00;  // Initial state is A
        end
        else begin
            state <= next_state;
        end
    end
      
    // State table
    always @(state or r) begin
        case (state)
            2'b00: begin // State A
                case (r)
                    3'b000: next_state = 2'b00;  // A
                    3'b001: next_state = 2'b01;  // B
                    3'b010: next_state = 2'b10;  // C
                    3'b111: next_state = 2'b11;  // D
                    default: next_state = 2'b00;  // A
                endcase
            end
            2'b01: begin // State B
                case (r)
                    3'b001: next_state = 2'b01;  // B
                    3'b000: next_state = 2'b00;  // A
                    default: next_state = 2'b01;  // B
                endcase
            end
            2'b10: begin // State C
                case (r)
                    3'b010: next_state = 2'b10;  // C
                    3'b000: next_state = 2'b00;  // A
                    default: next_state = 2'b10;  // C
                endcase
            end
            2'b11: begin // State D
                case (r)
                    3'b000: next_state = 2'b11;  // D
                    default: next_state = 2'b00;  // A
                endcase
            end
        endcase
    end
      
    // Output assignments
    assign g[1] = (state == 2'b01 || state == 2'b11);  // Device 1
    assign g[2] = (state == 2'b10 || state == 2'b11);  // Device 2
    assign g[3] = (state == 2'b11);                   // Device 3
      
endmodule
