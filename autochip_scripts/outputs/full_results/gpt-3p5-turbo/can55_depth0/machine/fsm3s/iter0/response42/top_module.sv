module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    // Declare the state enumeration
    typedef enum logic [1:0] {
        A,
        B,
        C,
        D
    } state_t;
    
    // Declare state and next_state variables
    state_t state, next_state;

    // Assign initial state
    initial begin
        state = A;
        next_state = A;
    end

    // Assign next state based on current state and inputs
    always @ (posedge clk) begin
        if (reset) begin
            state <= A;
            next_state <= A;
        end
        else begin
            state <= next_state;
            case (state)
                A: begin
                    if (in) begin
                        next_state <= B;
                    end
                    else begin
                        next_state <= A;
                    end
                end
                B: begin
                    if (in) begin
                        next_state <= B;
                    end
                    else begin
                        next_state <= C;
                    end
                end
                C: begin
                    if (in) begin
                        next_state <= D;
                    end
                    else begin
                        next_state <= A;
                    end
                end
                D: begin
                    if (in) begin
                        next_state <= B;
                    end
                    else begin
                        next_state <= C;
                    end
                end
            endcase
        end
    end

    // Assign output based on current state
    always @ (posedge clk) begin
        if (state == D) begin
            out <= 1;
        end
        else begin
            out <= 0;
        end
    end

endmodule
