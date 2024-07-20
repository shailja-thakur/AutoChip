module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    reg [2:0] state, next_state;
    
    parameter state_A = 3'b000;
    parameter state_B = 3'b001;
    parameter state_C = 3'b010;
    parameter state_S10 = 3'b011;
    parameter state_S11 = 3'b100;
    parameter state_S20 = 3'b101;
    parameter state_S21 = 3'b110;
    parameter state_S22 = 3'b111;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= state_A;
        end else begin
            state <= next_state;
        end
    end
    
    always @* begin
        case (state)
            state_A: begin
                if (s) begin
                    next_state = state_B;
                end else begin
                    next_state = state_A;
                end
            end
            state_B: begin
                if (w) begin
                    next_state = state_S11;
                end else begin
                    next_state = state_S10;
                end
            end
            state_C: begin
                if (w) begin
                    next_state = state_S11;
                end else begin
                    next_state = state_S10;
                end
            end
            state_S10: begin
                if (w) begin
                    next_state = state_S21;
                end else begin
                    next_state = state_S20;
                end
            end
            state_S11: begin
                if (w) begin
                    next_state = state_S22;
                end else begin
                    next_state = state_S21;
                end
            end
            state_S20: begin
                next_state = state_B;
            end
            state_S21: begin
                if (w) begin
                    next_state = state_C;
                end else begin
                    next_state = state_B;
                end
            end
            state_S22: begin
                if (w) begin
                    next_state = state_B;
                end else begin
                    next_state = state_C;
                end
            end
        endcase
    end
    
    always @(posedge clk) begin
        case (state)
            state_A, state_B, state_C: begin
                z <= 0;
            end
            default: begin
                z <= 1;
            end
        endcase
    end
    
endmodule
