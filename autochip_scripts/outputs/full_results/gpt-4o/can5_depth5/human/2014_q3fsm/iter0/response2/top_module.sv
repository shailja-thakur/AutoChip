module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // State declaration
    typedef enum reg [1:0] {
        A, // Initial / Reset state
        B, // State to count w values
        C, // State to count w values
        D  // State to count w values
    } state_t;
    
    state_t current_state, next_state;
    reg [1:0] count; // Counter to count number of '1's in w

    // State transition
    always @(posedge clk) begin
        if (reset)
            current_state <= A;
        else
            current_state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case(current_state)
            A: begin
                if (s == 1)
                    next_state = B;
                else
                    next_state = A;
            end
            B, C, D: begin
                next_state = (current_state == D) ? B : current_state + 1;
            end
            default: next_state = A;
        endcase
    end

    // Counter logic and output logic
    always @(posedge clk) begin
        if (reset) begin
            count <= 0;
            z <= 0;
        end
        else begin
            case (current_state)
                A: begin
                    if (s == 1) begin
                        count <= 0;
                        z <= 0;
                    end
                end
                B, C, D: begin
                    if (w == 1)
                        count <= count + 1;
                    
                    if (current_state == D) begin
                        if (count == 2)
                            z <= 1;
                        else
                            z <= 0;
                        count <= 0;
                    end
                end
                default: begin
                    count <= 0;
                    z <= 0;
                end
            endcase
        end
    end
endmodule
