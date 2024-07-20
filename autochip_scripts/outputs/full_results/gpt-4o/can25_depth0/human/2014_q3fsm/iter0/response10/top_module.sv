module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);
    
    // State declarations
    typedef enum logic [1:0] {
        A, // State for waiting for s=1
        B, // State for collecting w values
        C  // State for checking count
    } state_t;
    
    state_t state, next_state;
    reg [2:0] w_counter;
    reg [1:0] count;

    // State transition
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= A;
            w_counter <= 3'b000;
            count <= 2'b00;
        end
        else begin
            state <= next_state;
            if (state == B) begin
                w_counter <= {w_counter[1:0], w};   // Shift in the next w value
                if (w_counter[0])
                    count <= count + 1;           // Count the w=1's
            end
            else begin
                w_counter <= 3'b000;
                count <= 2'b00;
            end
        end
    end

    // Next state logic
    always_comb begin
        next_state = state;
        z = 1'b0;
        case (state)
            A: begin
                if (s)
                    next_state = B;
            end
            B: begin
                if (w_counter == 3'b111)         // After collecting 3 w values
                    next_state = C;
            end
            C: begin
                if (count == 2'b10)
                    z = 1'b1;
                next_state = B;
            end
        endcase
    end

endmodule
