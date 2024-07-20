module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output f,
    output g
);

    reg [3:0] state, next_state;

    assign f = (state == 2'b10) ? 1'b1 : 1'b0;
    assign g = (state == 2'b11 || state == 2'b100 || state == 2'b101) ? 1'b1 : 1'b0;

    always @(posedge clk or negedge resetn) begin
        if (~resetn) begin
            state <= 2'b00;
        end else begin
            state <= next_state;
        end
    end

    always @(state or x) begin
        case (state)
            2'b00: begin
                if (x) begin
                    next_state = 2'b01;
                end else begin
                    next_state = 2'b00;
                end
           end
           2'b01: begin
                if (x) begin
                    next_state = 2'b01;
                end else begin
                    next_state = 2'b10;
                end
           end
           2'b10: begin
                if (x) begin
                    next_state = 2'b11;
                end else begin
                    next_state = 2'b00;
                end
           end
           2'b11: begin
                if (y) begin
                    next_state = 2'b100;
                end else begin
                    next_state = 2'b101;
                end
           end
           2'b100: begin
                if (y) begin
                    next_state = 2'b100;
                end else begin
                    next_state = 2'b110;
                end
           end
           2'b101: begin
                if (y) begin
                    next_state = 2'b100;
                end else begin
                    next_state = 2'b100;
                end
           end
          default: next_state = 2'b00;
      endcase
  end

endmodule
