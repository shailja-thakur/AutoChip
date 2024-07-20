module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    typedef enum reg [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10
    } state_t;

    state_t state, next_state;
    reg [1:0] w_count;
    reg [1:0] cycle_count;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= STATE_A;
        end else begin
            state <= next_state;
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            w_count <= 2'b00;
            cycle_count <= 2'b00;
            z <= 1'b0;
        end else begin
            case (state)
                STATE_A: begin
                    if (s == 1) begin
                        next_state <= STATE_B;
                        w_count <= 2'b00;
                        cycle_count <= 2'b00;
                        z <= 1'b0;
                    end else begin
                        next_state <= STATE_A;
                    end
                end
                STATE_B: begin
                    if (cycle_count < 2) begin
                        cycle_count <= cycle_count + 1;
                        if (w == 1) begin
                            w_count <= w_count + 1;
                        end
                        next_state <= STATE_B;
                    end else begin
                        if (w == 1) begin
                            w_count <= w_count + 1;
                        end
                        if (w_count == 2) begin
                            z <= 1'b1;
                        end else begin
                            z <= 1'b0;
                        end
                        w_count <= 2'b00;
                        cycle_count <= 2'b00;
                        next_state <= STATE_B;
                    end
                end
            endcase
        end
    end
endmodule
