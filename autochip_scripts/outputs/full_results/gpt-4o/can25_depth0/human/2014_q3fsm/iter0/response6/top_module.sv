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
        C = 2'b10,
        D = 2'b11
    } state_t;
    
    state_t state, next_state;
    reg [1:0] w_count;
    
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end
    
    always_ff @(posedge clk) begin
        if (reset) begin
            w_count <= 2'b00;
        end else if (state == B) begin
            if (w) w_count <= w_count + 1;
        end else begin
            w_count <= 2'b00;
        end
    end
    
    always_ff @(posedge clk) begin
        if (reset) begin
            z <= 1'b0;
        end else if (state == D) begin
            z <= (w_count == 2);
        end else begin
            z <= 1'b0;
        end
    end
    
    always_comb begin
        case (state)
            A: begin
                if (s)
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                next_state = C;
            end
            C: begin
                next_state = D;
            end
            D: begin
                next_state = B;
            end
            default: begin
                next_state = A;
            end
        endcase
    end

endmodule
