module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // State encoding
    typedef enum reg [1:0] {
        A, // Reset/Initial state
        B, // Checking w
        C, // Dummy state for synchronous reset
        D  // Dummy state for synchronous reset
    } state_t;
    
    state_t state, next_state;
    reg [1:0] counter;

    // State transition
    always @(posedge clk) begin
        if (reset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        next_state = state;
        case (state)
            A: begin
                if (s)
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                if (counter == 2'd3)
                    next_state = C;
                else
                    next_state = B;
            end
            C: begin
                next_state = D;
            end
            D: begin
                next_state = B;
            end
        endcase
    end

    // Counter and output logic
    always @(posedge clk) begin
        if (reset) begin
            counter <= 2'b0;
            z <= 1'b0;
        end else begin
            case (state)
                A: begin
                    counter <= 2'b0;
                    z <= 1'b0;
                end
                B: begin
                    if (counter < 2'd3)
                        counter <= counter + 1'b1;
                end
                C: begin
                    if ((w && (counter == 2'd2)) || (counter == 2'd3)) // 2 out of 3 cycles
                        z <= 1'b1;
                    else
                        z <= 1'b0;
                end
                D: begin
                    counter <= 2'b1; // Reset counter to start checking next three cycles
                    z <= 1'b0;
                end
            endcase
        end
    end
endmodule
