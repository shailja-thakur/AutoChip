module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

    reg [2:0] state;
    reg [2:0] count;
    reg [2:0] next_count;
    reg [2:0] next_state;

    always @(posedge clk) begin
        if (reset) begin
            state <= 3'b000;
            count <= 3'b000;
        end else begin
            state <= next_state;
            count <= next_count;
        end
    end

    always @* begin
        next_count = count;
        next_state = state;
        case (state)
            3'b000: begin
                if (count == 3'b100) begin
                    if (in) begin
                        next_state = 3'b001;
                        next_count = 3'b000;
                    end else begin
                        next_state = 3'b000;
                        next_count = 3'b000;
                    end
                end else if (in == 1'b1) begin
                    next_state = 3'b001;
                    next_count = count + 1'b1;
                end
            end

            3'b001: begin
                if (in == 1'b1) begin
                    next_count = count + 1'b1;
                    if (count == 3'b100) begin
                        next_state = 3'b100;
                        next_count = 3'b000;
                    end
                end else begin
                    next_count = 3'b000;
                    next_state = 3'b010;
                end
            end

            3'b010: begin
                if (count == 3'b100) begin
                    if (in) begin
                        next_state = 3'b001;
                        next_count = 3'b000;
                    end else begin
                        next_state = 3'b000;
                        next_count = 3'b000;
                    end
                end else if (in == 1'b1) begin
                    next_state = 3'b001;
                    next_count = count + 1'b1;
                end
            end

            3'b011: begin
                if (in == 1'b1) begin
                    next_count = count + 1'b1;
                    if (count == 3'b100) begin
                        next_state = 3'b100;
                        next_count = 3'b000;
                    end
                end else begin
                    next_count = 3'b000;
                    next_state = 3'b010;
                end
            end

            3'b100: begin
                if (in == 1'b0) begin
                    next_state = 3'b000;
                    next_count = 3'b000;
                end else begin
                    next_state = 3'b001;
                    next_count = 3'b001;
                end
            end

            3'b101: begin
                if (in == 1'b0) begin
                    next_state = 3'b010;
                    next_count = count + 1'b1;
                end else begin
                    next_state = 3'b001;
                    next_count = count + 1'b1;
                end
            end

            3'b110: begin
                if (in == 1'b0) begin
                    next_state = 3'b010;
                    next_count = count + 1'b1;
                end else begin
                    next_state = 3'b001;
                    next_count = count + 1'b1;
                end
            end

            3'b111: begin
                if (in == 1'b0) begin
                    next_state = 3'b010;
                    next_count = count + 1'b1;
                end else begin
                    next_state = 3'b001;
                    next_count = count + 1'b1;
                end
            end
        endcase
    end

    always @(posedge clk) begin
        if (reset)
            disc <= 1'b0;
        else if (state == 3'b100)
            disc <= 1'b1;
        else
            disc <= 1'b0;
    end

    always @(posedge clk) begin
        if (reset)
            flag <= 1'b0;
        else if (state == 3'b101)
            flag <= 1'b1;
        else
            flag <= 1'b0;
    end

    always @(posedge clk) begin
        if (reset)
            err <= 1'b0;
        else if (state == 3'b111)
            err <= 1'b1;
        else
            err <= 1'b0;
    end

endmodule
