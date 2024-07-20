module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // State encoding
    typedef enum reg [2:0] {
        A = 3'b000,
        B = 3'b001,
        B0 = 3'b010,
        B1 = 3'b011,
        B2 = 3'b100,
        B3 = 3'b101
    } state_t;
    
    state_t state, next_state;
    reg [1:0] w_count; // Counter for the number of times w=1

    // State register
    always @(posedge clk) begin
        if (reset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            A: begin
                if (s) begin
                    next_state = B;
                end else begin
                    next_state = A;
                end
            end
            
            B: begin
                next_state = B0;
            end
            
            B0: begin
                next_state = B1;
            end
            
            B1: begin
                next_state = B2;
            end
            
            B2: begin
                next_state = B3;
            end
            
            B3: begin
                if (s) begin
                    next_state = B;
                end else begin
                    next_state = A;
                end
            end

            default: next_state = A;
        endcase
    end

    // Output logic and counting logic
    always @(posedge clk) begin
        if (reset) begin
            z <= 0;
            w_count <= 0;
        end else begin
            case (state)
                A: begin
                    z <= 0;
                    w_count <= 0;
                end
                
                B: begin
                    w_count <= 0;
                end
                
                B0: begin
                    if (w) begin
                        w_count <= w_count + 1;
                    end
                end
                
                B1: begin
                    if (w) begin
                        w_count <= w_count + 1;
                    end
                end
                
                B2: begin
                    if (w) begin
                        w_count <= w_count + 1;
                    end
                end
                
                B3: begin
                    if (w_count == 2) begin
                        z <= 1;
                    end else begin
                        z <= 0;
                    end
                    w_count <= 0; // reset counter before next 3-cycle check
                end
            endcase
        end
    end
endmodule
