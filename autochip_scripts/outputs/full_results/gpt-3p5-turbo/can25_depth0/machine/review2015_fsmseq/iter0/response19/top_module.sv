module top_module(
    input clk,
    input reset,
    input data,
    output start_shifting);

    reg [2:0] state, next_state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 0;
        end else begin
            state <= next_state;
        end
    end

    always @* begin
        case(state)
            3'b000: begin
                if (data) begin
                    next_state = 3'b001;
                end else begin
                    next_state = 3'b000;
                end
            end
            3'b001: begin
                if (data) begin
                    next_state = 3'b011;
                end else begin
                    next_state = 3'b000;
                end
            end
            3'b011: begin
                if (data) begin
                    next_state = 3'b011;
                end else begin
                    next_state = 3'b110;
                end
            end
            3'b110: begin
                if (data) begin
                    next_state = 3'b111;
                end else begin
                    next_state = 3'b000;
               end
            end
            3'b111: begin
                next_state = 3'b111;
            end
            default: begin
                next_state = 3'b000;
            end
        endcase
    end

    assign start_shifting = (state == 3'b111);

endmodule
