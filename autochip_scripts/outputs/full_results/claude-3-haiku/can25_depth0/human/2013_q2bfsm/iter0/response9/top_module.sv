module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    localparam STATE_A = 2'b00; // Reset state
    localparam STATE_B = 2'b01; // Set f to 1
    localparam STATE_C = 2'b10; // Monitor x and set g
    localparam STATE_D = 2'b11; // Monitor y and maintain g

    reg [1:0] state;
    reg [1:0] x_count;

    always @(posedge clk, negedge resetn) begin
        if (~resetn) begin
            state <= STATE_A;
            f <= 0;
            g <= 0;
            x_count <= 0;
        end
        else begin
            case (state)
                STATE_A: begin
                    f <= 0;
                    g <= 0;
                    if (resetn) begin
                        state <= STATE_B;
                    end
                end
                STATE_B: begin
                    f <= 1;
                    state <= STATE_C;
                end
                STATE_C: begin
                    f <= 0;
                    if (x == 1) begin
                        x_count <= x_count + 1;
                    end
                    else if (x_count == 2'b10) begin
                        state <= STATE_D;
                        g <= 1;
                    end
                    else begin
                        x_count <= 0;
                    end
                end
                STATE_D: begin
                    if (y == 1) begin
                        g <= 1;
                    end
                    else if (x_count == 2'b10) begin
                        g <= 0;
                    end
                    x_count <= x_count + 1;
                end
            endcase
        end
    end

endmodule
