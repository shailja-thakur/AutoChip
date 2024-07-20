module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State encoding
    typedef enum reg [1:0] {
        S0, // Initial state
        S1, // After detecting the first 1
        S2, // Emitting 0s
        S3  // Emitting 1s
    } state_t;
    
    state_t state, next_state;
    reg complement;

    // State transition
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= S0;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            S0: begin
                if (x == 1'b0) begin
                    next_state = S0;
                end else begin
                    next_state = S1;
                end
            end
            
            S1: begin
                if (x == 1'b0) begin
                    next_state = S2;
                end else begin
                    next_state = S1;
                end
            end
            
            S2: begin
                next_state = S2;
            end
            
            S3: begin
                next_state = S3;
            end
            
            default: begin
                next_state = S0;
            end
        endcase
    end

    // Output and complement logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            z <= 0;
            complement <= 0;
        end else begin
            case (state)
                S0: begin
                    z <= x;
                    complement <= 0;
                end
                
                S1: begin
                    z <= ~x;
                    complement <= 1;
                end
                
                S2: begin
                    z <= x ^ complement;
                end
                
                S3: begin
                    z <= x;
                end
            endcase
        end
    end
endmodule
