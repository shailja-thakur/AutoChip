module A(
    input x,
    input y,
    output z);

    assign z = (x ^ y) & x;

endmodule
module B(
    input x,
    input y,
    output z);

    // Waveform for B module
    reg [3:0] time;
    reg x_sim;
    reg y_sim;
    wire z_sim;

    initial begin
        time = 0;
        x_sim = 0;
        y_sim = 0;
    end

    always @(negedge time) begin
        case(time)
            0: begin x_sim = 0; y_sim = 0; end
            25: begin x_sim = 1; y_sim = 0; end
            35: begin x_sim = 0; y_sim = 1; end
            45: begin x_sim = 1; y_sim = 1; end
            55: begin x_sim = 0; y_sim = 0; end
            60: begin x_sim = 0; y_sim = 1; end
            70: begin x_sim = 1; y_sim = 1; end
            75: begin x_sim = 0; y_sim = 1; end
            default: begin x_sim = 0; y_sim = 0; end
        endcase
        
        #5; // Wait for 5ns
        time = time + 5;
    end

    assign z = z_sim;

endmodule
module top_module(
    input x,
    input y,
    output z);

    wire a1_out;
    wire a2_out;
    wire b1_out;
    wire b2_out;
    wire or_out;
    wire and_out;

    A a1(.x(x), .y(y), .z(a1_out));
    A a2(.x(x), .y(y), .z(a2_out));
    B b1(.x(x), .y(y), .z(b1_out));
    B b2(.x(x), .y(y), .z(b2_out));

    assign or_out = a1_out | b1_out;
    assign and_out = a2_out & b2_out;
    assign z = or_out ^ and_out;

endmodule
