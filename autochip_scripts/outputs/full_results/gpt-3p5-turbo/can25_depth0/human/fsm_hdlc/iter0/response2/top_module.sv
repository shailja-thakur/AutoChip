module top_module (
    input clk,
    input reset,
    input in,
    output disc,
    output flag,
    output err);

reg [2:0] state, next_state;
wire seq_detected;

assign seq_detected = (state == 3'b001);

always @(posedge clk) begin
    if (reset) begin
        state <= 3'b000;
    end else begin
        state <= next_state;
    end
end

always @(state or in) begin
    case (state)
        3'b000: begin
            if (in) begin
                next_state = 3'b001;
            end else begin
                next_state = 3'b000;
            end
        end
        3'b001: begin
            if (in) begin
                next_state = 3'b010;
            end else begin
                next_state = 3'b001;
            end
        end
        3'b010: begin
            if (in) begin
                next_state = 3'b011;
            end else begin
                next_state = 3'b001;
            end
        end
        3'b011: begin
            if (in) begin
                next_state = 3'b011;
            end else begin
                next_state = 3'b100;
            end
        end
        3'b100: begin
            if (in) begin
                next_state = 3'b010;
            end else begin
                next_state = 3'b000;
            end
        end
    endcase
end

assign disc = seq_detected;
assign flag = (state == 3'b100);
assign err = (state == 3'b011);

endmodule
