module top_module (
    input clk,
    input reset,
    input in,
    output disc,
    output flag,
    output err);

    reg [2:0] state;

    // Mealy output
    reg disc_out;
    reg flag_out;
    reg err_out;

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 0;
        else begin
            case (state)
                0: begin
                    disc_out <= 0;
                    flag_out <= 0;
                    err_out <= 0;
                    if (in)
                        state <= 1;
                end
                1: begin
                    disc_out <= 0;
                    flag_out <= 0;
                    err_out <= 0;
                    if (in)
                        state <= 2;
                    else
                        state <= 0;
                end
                2: begin
                    disc_out <= 1;
                    flag_out <= 0;
                    err_out <= 0;
                    if (in)
                        state <= 3;
                    else
                        state <= 0;
                end
                3: begin
                    disc_out <= 0;
                    flag_out <= 1;
                    err_out <= 0;
                    if (in)
                        state <= 4;
                    else
                        state <= 0;
                end
                4: begin
                    disc_out <= 0;
                    flag_out <= 1;
                    err_out <= 0;
                    if (in)
                        state <= 5;
                    else
                        state <= 6;
                end
                5: begin
                    disc_out <= 0;
                    flag_out <= 0;
                    err_out <= 0;
                    if (in)
                        state <= 6;
                    else
                        state <= 4;
                end
                6: begin
                    disc_out <= 0;
                    flag_out <= 0;
                    err_out <= 0;
                    if (in)
                        state <= 7;
                    else
                        state <= 0;
                end
                7: begin
                    disc_out <= 0;
                    flag_out <= 0;
                    err_out <= 1;
                    if (in)
                        state <= 7;
                    else
                        state <= 0;
                end
                default: state <= 0;
            endcase
        end
    end

    assign disc = disc_out;
    assign flag = flag_out;
    assign err = err_out;

endmodule
