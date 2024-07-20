module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);

reg [2:0] state, next_state;
reg [1:0] counter;
reg [1:0] monitor_y;

localparam A = 3'b000;
localparam B = 3'b001;
localparam C = 3'b010;
localparam D = 3'b011;
localparam E = 3'b100;

// State transition logic
always @(*) begin
    case(state)
        A: next_state = resetn ? B : A;
        B: next_state = C;
        C: if (x && counter == 2'b10)
                next_state = D;
            else
                next_state = C;
        D: if (monitor_y == 2'b10 || y)
                next_state = E;
            else
                next_state = D;
        E: next_state = E;
        default: next_state = A;
    endcase
end

// State flip-flops
always @(posedge clk) begin
    if (!resetn)
        state <= A;
    else
        state <= next_state;
end

// Output and counter logic
always @(posedge clk) begin
    if (!resetn) begin
        f <= 0;
        g <= 0;
        counter <= 2'b00;
        monitor_y <= 2'b00;
    end else begin
        case(state)
            A: f <= 0;
            B: f <= 1;
            C: begin
                f <= 0;
                counter <= (x && counter < 2'b10) ? counter + 1 : counter;
            end
            D: begin
                f <= 0;
                g <= 1;
                if (!y)
                    monitor_y <= monitor_y + 1;
                if (y)
                    monitor_y <= 2'b10;  // Force y monitored as '1' if encountered within two cycles
            end
            E: if (monitor_y < 2'b10)
                    g <= 0;
        endcase
    end
end

endmodule
