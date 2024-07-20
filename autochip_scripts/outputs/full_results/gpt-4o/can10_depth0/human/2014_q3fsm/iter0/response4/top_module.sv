module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10
    } state_t;
    
    state_t state, next_state;
    reg [1:0] w_count;

    always_ff @(posedge clk) begin
        if (reset) begin
            state <= A;
            w_count <= 2'b00;
            z <= 0;
        end else begin
            state <= next_state;
            if (state == B) begin
                w_count <= w_count + w;
            end else if (state == C) begin
                w_count <= 2'b00;
            end
        end
    end

    always_comb begin
        case (state)
            A: begin
                z = 0;
                if (s == 0) begin
                    next_state = A;
                end else begin
                    next_state = B;
                end
            end

            B: begin
                if (w_count == 2'b01) begin
                    if (w == 1) begin
                        z = 1;
                        next_state = C;
                    end else begin
                        z = 0;
                        next_state = C;
                    end
                end else begin
                    z = 0;
                    next_state = B;
                end
            end
            
            C: begin
                z = 0;
                next_state = B;
            end

            default: begin
                z = 0;
                next_state = A;
            end
        endcase
    end

endmodule
