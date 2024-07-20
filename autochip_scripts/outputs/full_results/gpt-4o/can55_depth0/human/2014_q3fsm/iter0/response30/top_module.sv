module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);
    // State encoding
    typedef enum reg [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;

    state_t state, next_state;

    reg [1:0] count;

    // State transition logic
    always @ (posedge clk) begin
        if (reset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @ (*) begin
        case (state)
            A: begin
                if (s == 1)
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                if (count == 2)
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
            default: next_state = A;
        endcase
    end

    // Output logic and counter
    always @ (posedge clk) begin
        if (reset) begin
            z <= 0;
            count <= 0;
        end else begin
            case (state)
                A: begin
                    z <= 0;
                    count <= 0;
                end
                B: begin
                    if (count < 2)
                        count <= count + w;
                end
                C: begin
                    z <= 1;
                end
                D: begin
                    z <= 0;
                    count <= 0;
                end
                default: begin
                    z <= 0;
                    count <= 0;
                end
            endcase
        end
    end
endmodule
