module top_module (
    input clk,
    input areset,
    input x,
    output z
);

reg [7:0] counter; // Counter for the state machine

// Declare the states of the state machine
parameter STATE_IDLE = 2'b00;
parameter STATE_CONVERT = 2'b01;
parameter STATE_COMPLETE = 2'b10;

reg [7:0] input_buffer = 0;
reg [7:0] output_buffer = 0;
reg [7:0] two_complement = 0;

always @(posedge clk or negedge areset) begin
    if (areset == 0) begin
        counter <= STATE_IDLE;
        input_buffer <= 0;
        output_buffer <= 0;
        two_complement <= 0;
    end else begin
        case (counter)
            STATE_IDLE: begin
                if (areset == 0) begin
                    counter <= STATE_IDLE;
                    input_buffer <= 0;
                    output_buffer <= 0;
                    two_complement <= 0;
                end else if (x == 1'b1) begin
                    counter <= STATE_CONVERT;
                    input_buffer <= x;
                    output_buffer <= x;
                    two_complement <= ~x[7:0] + 1;
                end else begin
                    counter <= STATE_IDLE;
                    input_buffer <= x;
                    output_buffer <= x;
                    two_complement <= 0;
                end
            end

            STATE_CONVERT: begin
                if (areset == 0) begin
                    counter <= STATE_IDLE;
                    input_buffer <= 0;
                    output_buffer <= 0;
                    two_complement <= 0;
                end else if (x == 1'b1) begin
                    counter <= STATE_CONVERT;
                    input_buffer <= x;
                    output_buffer <= output_buffer << 1;
                    two_complement <= ~x[7:0] + 1;
                end else begin
                    counter <= STATE_COMPLETE;
                    input_buffer <= x;
                    output_buffer <= output_buffer << 1;
                    two_complement <= ~x[7:0] + 1;
                end
            end

            STATE_COMPLETE: begin
                if (areset == 0) begin
                    counter <= STATE_IDLE;
                    input_buffer <= 0;
                    output_buffer <= 0;
                    two_complement <= 0;
                end else begin
                    counter <= STATE_IDLE;
                    input_buffer <= x;
                    output_buffer <= x;
                    two_complement <= 0;
                end
            end
        endcase
    end
end

assign z = two_complement;

endmodule
