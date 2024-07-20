module top_module(
    input clk,
    input reset,
    output shift_ena);

    reg [2:0] state;
    reg [2:0] next_state;

    parameter IDLE = 3'b000;
    parameter ENABLED = 3'b001;
    parameter SHIFT = 3'b010;
    parameter FINISH = 3'b011;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    always @(state) begin
        case (state)
            IDLE: begin
                next_state <= ENABLED;
            end
            ENABLED: begin
                next_state <= SHIFT;
            end
            SHIFT: begin
                next_state <= FINISH;
            end
            FINISH: begin
                next_state <= IDLE;
            end
            default: begin
                next_state <= IDLE;
            end
        endcase
    end

    always @(state) begin
        case (state)
            IDLE: begin
                shift_ena <= 1;
            end
            ENABLED: begin
                shift_ena <= 1;
            end
            SHIFT: begin
                shift_ena <= 0;
            end
            FINISH: begin
                shift_ena <= 0;
            end
            default: begin
                shift_ena <= 0;
            end
        endcase
    end

endmodule
