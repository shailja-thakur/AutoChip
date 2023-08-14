module top_module (
    input clk,
    input [2:0] y,
    input x,
    output Y0,
    output z
);

    reg [2:0] state;
    reg Y0;

    wire [2:0] next_state;
    wire z;

    always @(posedge clk) begin
        next_state = state;
        if (x == 1) begin
            next_state = state + 1;
        end

        case (state)
            3'b000:
                if (x == 0) begin
                    Y0 = 1;
                    z = 0;
                end else begin
                    Y0 = 0;
                    z = 1;
                end

            3'b001:
                Y0 = 0;
                z = 0;

            3'b010:
                Y0 = 1;
                z = 0;

            3'b011:
                Y0 = 0;
                z = 1;

            3'b100:
                Y0 = 1;
                z = 1;

            3'b101:
                Y0 = 0;
                z = 0;

            3'b110:
                Y0 = 1;
                z = 0;

            3'b111:
                Y0 = 0;
                z = 1;
        endcase

        state <= next_state;
    end

endmodule