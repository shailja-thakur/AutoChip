module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

reg [1:0] counter;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        counter <= 2'b01;
    end else if (train_valid) begin
        if (train_taken) begin
            if (counter == 2'b11) begin
                counter <= 2'b11;
            end else begin
                counter <= counter + 1;
            end
        end else begin
            if (counter == 2'b00) begin
                counter <= 2'b00;
            end else begin
                counter <= counter - 1;
            end
        end
    end
end

assign state = counter;

endmodule
