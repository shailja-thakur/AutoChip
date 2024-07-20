module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

reg [1:0] state;
reg [2:0] x_history;
reg y_detected;

always @(posedge clk or negedge resetn) begin
    if (~resetn) begin
        state <= 2'b0;
        f <= 1'b0;
        g <= 1'b0;
    end else begin
        case(state)
            2'b00:
                if (x == 1'b0) begin
                    state <= 2'b01;
                    f <= 1'b1;
                end
            2'b01:
                if (x == 1'b0) begin
                    state <= 2'b10;
                end else begin
                    state <= 2'b00;
                    f <= 1'b0;
                end
            2'b10:
                x_history <= {x_history[1:0], x};
                
                if (x_history == 3'b101) begin
                    state <= 2'b11;
                end
            2'b11:
                g <= 1'b1;
                
                if (y == 1'b1) begin
                    y_detected <= 1'b1;
                end else if (y == 1'b0) begin
                    y_detected <= 1'b0;
                end
                
                if (~y_detected) begin
                    state <= 2'b00;
                    g <= 1'b0;
                end
        endcase
    end
end

endmodule
