module top_module (
    input clk,
    input reset,
    input in,
    output disc,
    output flag,
    output err);

    reg [2:0] state;
    reg prev_in;
    reg [2:0] next_state;
    wire flag_next;
    wire disc_next;
    wire err_next;

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 3'b000;
        else
            state <= next_state;
    end

    always @* begin
        prev_in = in;

        case (state)
            3'b000: begin // Idle
                if (in == 1'b0) begin
                    next_state = 3'b000;
                    flag_next = 1'b0;
                    disc_next = 1'b0;
                    err_next = 1'b0;
                end
                else begin
                    next_state = 3'b001;
                    flag_next = 1'b0;
                    disc_next = 1'b0;
                    err_next = 1'b0;
                end
            end

            3'b001: begin // One
                if (in == 1'b0) begin
                    next_state = 3'b010;
                    flag_next = 1'b0;
                    disc_next = 1'b0;
                    err_next = 1'b0;
                end
                else begin
                    next_state = 3'b001;
                    flag_next = 1'b0;
                    disc_next = 1'b0;
                    err_next = 1'b0;
                end
            end

            3'b010: begin // Two
                if (in == 1'b0) begin
                    next_state = 3'b011;
                    flag_next = 1'b0;
                    disc_next = 1'b0;
                    err_next = 1'b0;
                end
                else begin
                    next_state = 3'b001;
                    flag_next = 1'b0;
                    disc_next = 1'b0;
                    err_next = 1'b0;
                end
            end

            3'b011: begin // Three
                if (in == 1'b0) begin
                    next_state = 3'b100;
                    flag_next = 1'b0;
                    disc_next = 1'b0;
                    err_next = 1'b0;
                end
                else begin
                    next_state = 3'b001;
                    flag_next = 1'b0;
                    disc_next = 1'b0;
                    err_next = 1'b0;
                end
            end

            3'b100: begin // Four
                if (in == 1'b0) begin
                    next_state = 3'b101;
                    flag_next = 1'b0;
                    disc_next = 1'b0;
                    err_next = 1'b0;
                end
                else begin
                    next_state = 3'b111;
                    flag_next = 1'b0;
                    disc_next = 1'b1;
                    err_next = 1'b0;
                end
            end

            3'b101: begin // Five
                if (in == 1'b0) begin
                    next_state = 3'b110;
                    flag_next = 1'b0;
                    disc_next = 1'b0;
                    err_next = 1'b0;
                end
                else begin
                    next_state = 3'b111;
                    flag_next = 1'b0;
                    disc_next = 1'b1;
                    err_next = 1'b0;
                end
            end

            3'b110: begin // Six
                if (in == 1'b0) begin
                    next_state = 3'b111;
                    flag_next = 1'b1;
                    disc_next = 1'b0;
                    err_next = 1'b0;
                end
                else begin
                    next_state = 3'b111;
                    flag_next = 1'b0;
                    disc_next = 1'b1;
                    err_next = 1'b0;
                end
            end

            3'b111: begin // Discard or error
                if (in == 1'b0) begin
                    next_state = 3'b000;
                    flag_next = 1'b0;
                    disc_next = 1'b0;
                    err_next = 1'b0;
                end
                else if (prev_in == 1'b1) begin
                    next_state = 3'b111;
                    flag_next = 1'b0;
                    disc_next = 1'b0;
                    err_next = 1'b1;
                end
                else begin
                    next_state = 3'b001;
                    flag_next = 1'b0;
                    disc_next = 1'b0;
                    err_next = 1'b0;
                end
            end
        endcase
    end

    always @(posedge clk) begin
        disc <= disc_next;
        flag <= flag_next;
        err <= err_next;
    end
endmodule
